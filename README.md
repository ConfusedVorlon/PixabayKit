# PixabayKit

A simple Swift wrapper to access Pixabay.
Optimised for 'infinite scrolling' type displays

## Installation

Use SPM

## Usage

Configure the client with your API, 

    let config = PiClient.Config(key:YOUR_ACCESS_KEY)
    PiClient.setup(config)
    let client = PiClient.shared

then use the shared singleton


    search = client.fetch(searchTerm: searchTerm) {
        [weak self](result) in
        switch result {
        case .failure(let error):
            DDLogError("Pixabay failed with error: \(error)")
        case .success(let thisSearch):
            if thisSearch === self?.search {
                self?.updateUI()
            //photos are now available in search.photos
            }
            
        }
    }

to fetch more (after the initial search has completed)

    search.getNextPage()
