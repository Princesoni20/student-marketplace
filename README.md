# Student Marketplace

A full-stack student-focused e-commerce marketplace built with Next.js, Node.js, PostgreSQL, Redis, Docker, and Kubernetes.

## Overview

Student Marketplace is a full-stack web application designed for students to discover and purchase academic books, stationery, laptops, bags, laboratory equipment, and other student essentials.

The application uses a Next.js frontend with backend microservices for authentication and products. PostgreSQL is used for persistent data storage and Redis is used as an application infrastructure component.

## Features

- Student-focused product marketplace
- Product listing
- Product details
- Product categories and subcategories
- Product images
- Product search and filtering
- User registration and login
- JWT-based authentication
- User account
- Shopping cart
- Wishlist
- Checkout flow
- PostgreSQL database
- Redis integration
- REST APIs
- Docker containerization
- Docker Compose
- Kubernetes deployment
- Kubernetes service discovery
- Persistent storage
- Kubernetes service scaling

## Tech Stack

### Frontend

- Next.js
- React
- TypeScript
- CSS
- Next.js App Router

### Backend

- Node.js
- Express.js
- REST APIs
- Microservice architecture

### Backend Services

- Authentication Service
- Product Service

### Database & Infrastructure

- PostgreSQL
- Redis
- Docker
- Docker Compose
- Kubernetes
- Kind

### Development Tools

- Git
- GitHub
- VS Code
- npm
- kubectl
- Postman

## Architecture

```text
                         ┌──────────────────────┐
                         │      Next.js UI      │
                         │      Frontend        │
                         └──────────┬───────────┘
                                    │
                                    ▼
                         ┌──────────────────────┐
                         │    Next.js API       │
                         │    Proxy Routes      │
                         └────────┬─────────────┘
                                  │
                    ┌─────────────┴─────────────┐
                    ▼                           ▼
          ┌──────────────────┐        ┌──────────────────┐
          │  Auth Service    │        │ Product Service  │
          │     :5002        │        │      :5001       │
          └────────┬─────────┘        └────────┬─────────┘
                   │                           │
                   └─────────────┬─────────────┘
                                 ▼
                        ┌──────────────────┐
                        │    PostgreSQL    │
                        │      :5432       │
                        └──────────────────┘
                                 │
                        ┌────────▼────────┐
                        │      Redis      │
                        │      :6379      │
                        └─────────────────┘