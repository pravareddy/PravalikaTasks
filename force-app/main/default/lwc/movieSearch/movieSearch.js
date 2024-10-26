import { LightningElement, track, api } from 'lwc';
import getMovies from '@salesforce/apex/MovieController.getMovies';
export default class MovieSearch extends LightningElement {
    @track movieList = [];
    @track error;
    @track movieName;
    connectedCallback(){
        this.fetchMovies();
    }

    fetchMovies(){
        getMovies()
        .then(data => {
            this.movieList = data;
            this.error= undefined;
            console.log('this.movieList>>>>>>>>>>.'+this.movieList);
        }).catch(error => {
            this.error=error;
            this.movieList = undefined;
            console.log('this.error>>>>>>>>>>.'+this.error);

        });
    }

    openModal(MovieTitle){
        this.movieName = MovieTitle;
        this.isModalOpen=true;

    }
    // Method to close the modal
    handleCloseModal() {
        this.isModalOpen = false; // Hide the modal
    }
    
}