# Gelrss Docker

This project provides a way to run [Gelrss](https://github.com/Bakalhau/Gelrss) using Docker and Docker Compose.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) or [podman](https://podman.io/)
- [Docker Compose](https://docs.docker.com/compose/install/) or [podman compose](https://docs.podman.io/en/latest/markdown/podman-compose.1.html)

## Quick Start

1.  **Clone this repository:**
    ```bash
    git clone <repository_url>
    cd gelrss-docker
    ```

2.  **Configure API Keys and Environment:**

    Create a `.env` file by copying the example file:

    ```bash
    cp .env.example .env
    ```

    Now, edit the `.env` file with a text editor. See [Gelrss](https://github.com/Bakalhau/Gelrss/blob/main/README.md) for details.

3.  **Add Artist Feeds:**

    Feed configurations are stored as `.json` files inside the `configs/` directory. An example is provided in `configs/artist.json.example`.

    To add a new feed, see [Gelrss](https://github.com/Bakalhau/Gelrss/blob/main/README.md) for details.

4.  **Set Permissions for podman:**

    The application requires write access to the `data/` directory to store its database. The `gelrss` service runs as the `node` user (UID 1000) inside the container. To grant this user appropriate write access to the host's `data/` directory, you can change its ownership via unshare:

    ```bash
    podman unshare chown 1000:1000 -R data/
    ```

    This command changes the owner and group of the `data/` directory to UID 1000 and GID 1000, matching the `node` user inside the container.

## Usage

### Accessing the Web Interface and Feeds

-   **Web UI**: Open your browser and navigate to `http://localhost:24454` to see the status of all your configured feeds.
-   **RSS Feed**: The RSS feed for an artist will be available at `http://localhost:24454/rss/<gelbooru_tag>`.

### Managing the Container

-   **Update the Application:**
    To pull the latest version of Gelrss from its repository and rebuild the Docker image, run:
    ```bash
    docker-compose build --no-cache
    docker-compose up -d
    ```

## Data Persistence

-   **Feed Configurations**: Your feed configurations in the `configs/` directory are directly mounted into the container. Any changes you make locally will be reflected in the application.
-   **Cache**: A Docker named volume `gelrss-cache` is used to store the application's cache. This ensures that the cache persists even if the container is removed and recreated.
