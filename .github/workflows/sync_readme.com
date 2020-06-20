---
name: Sync Readme

on:
  push:
    branches:
      - gates
  schedule:
    - cron: "0 0 * * *" # daily


jobs:
  sync:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v2

      - name: Sync
        uses: ms-jpq/sync-dockerhub-readme@v1
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}
          repository: ${{ secrets.DOCKER_USERNAME }}/kvm-windows
          readme: "./README.md"