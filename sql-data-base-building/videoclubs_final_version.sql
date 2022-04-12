create table actor
(
    actor_id    int auto_increment
        primary key,
    first_name  varchar(45)                         not null,
    last_name   varchar(45)                         not null,
    last_update timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP
);

create table category
(
    category_id int auto_increment
        primary key,
    name        varchar(45)                         not null,
    last_update timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP
);

create table country
(
    country_id  int auto_increment
        primary key,
    name        varchar(45)                         not null,
    last_update timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP
);

create table city
(
    city_id     int auto_increment
        primary key,
    city        varchar(50)                         not null,
    country_id  int                                 not null,
    last_update timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    constraint city_country_country_id_fk
        foreign key (city_id) references country (country_id)
            on update cascade on delete cascade
);

create table address
(
    address_id  int auto_increment
        primary key,
    address     varchar(200)                        not null,
    address2    varchar(200)                        null,
    district    varchar(200)                        not null,
    city_id     int                                 not null,
    postal_code varchar(10)                         not null,
    phone       varchar(200)                        null,
    last_update timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    constraint address_city_city_id_fk
        foreign key (city_id) references city (city_id)
);

create index address_city_id_index
    on address (city_id);

create index city_country_id_index
    on city (country_id);

create table film
(
    film_id          int auto_increment
        primary key,
    title            varchar(255)                        not null,
    description      varchar(255)                        not null,
    release_year     int                                 not null,
    language_id      int                                 not null,
    rental_duration  int                                 not null,
    rental_rate      decimal(4, 2)                       not null,
    length           int                                 not null,
    replacement_cost decimal(5, 2)                       not null,
    rating           varchar(10)                         not null,
    last_update      timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP
);

create table actor_info
(
    actor_id    int                                 not null,
    film_id     int                                 not null,
    last_update timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    primary key (actor_id, film_id),
    constraint actor_info_actor_actor_id_fk
        foreign key (actor_id) references actor (actor_id),
    constraint actor_info_film_film_id_fk
        foreign key (film_id) references film (film_id)
);

create index actor_info_actor_id_index
    on actor_info (actor_id);

create index actor_info_film_id_index
    on actor_info (film_id);

create table category_film
(
    category_id int                                 not null,
    film_id     int                                 not null,
    last_update timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    primary key (category_id, film_id),
    constraint category_film_category_category_id_fk
        foreign key (category_id) references category (category_id),
    constraint category_film_film_film_id_fk
        foreign key (film_id) references film (film_id)
);

create index category_film_category_id_index
    on category_film (category_id);

create index category_film_film_id_index
    on category_film (film_id);

create table inventory
(
    inventory_id int auto_increment
        primary key,
    film_id      int                                 not null,
    store_id     int                                 not null,
    last_update  timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    constraint inventory_film_film_id_fk
        foreign key (film_id) references film (film_id)
            on update cascade on delete cascade
);

create index inventory_film_id_index
    on inventory (film_id);

create index inventory_store_id_index
    on inventory (store_id);

create table language
(
    language_id int auto_increment
        primary key,
    name        varchar(20)                         not null,
    last_update timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP
);

create table category_info
(
    category_id int                                 not null,
    language_id int                                 not null,
    last_update timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    primary key (category_id, language_id),
    constraint category_info_category_category_id_fk
        foreign key (category_id) references category (category_id),
    constraint category_info_language_language_id_fk
        foreign key (language_id) references language (language_id)
);

create index category_info_category_id_index
    on category_info (category_id);

create index category_info_language_id_index
    on category_info (language_id);

create table film_info
(
    film_id     int                                 not null,
    language_id int                                 not null,
    last_update timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    primary key (film_id, language_id),
    constraint film_info_film_film_id_fk
        foreign key (film_id) references film (film_id),
    constraint film_info_language_language_id_fk
        foreign key (language_id) references language (language_id)
);

create index film_info_film_id_index
    on film_info (film_id);

create index film_info_language_id_index
    on film_info (language_id);

create table old_hdd
(
    old_HDD_id   int auto_increment
        primary key,
    first_name   varchar(45) not null,
    last_name    varchar(45) not null,
    title        varchar(45) not null,
    release_year int         not null,
    category_id  int         not null,
    constraint old_hdd_category_category_id_fk
        foreign key (category_id) references category (category_id)
);

create index old_hdd_category_id_index
    on old_hdd (category_id);

create index old_hdd_old_HDD_id_index
    on old_hdd (old_HDD_id);

create table old_hdd_info
(
    old_HDD_id  int                                 not null,
    film_id     int                                 not null,
    last_update timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    primary key (old_HDD_id, film_id),
    constraint old_hdd_info_film_film_id_fk
        foreign key (film_id) references film (film_id),
    constraint old_hdd_info_old_hdd_old_HDD_id_fk
        foreign key (old_HDD_id) references old_hdd (old_HDD_id)
);

create index old_hdd_info_film_id_index
    on old_hdd_info (film_id);

create index old_hdd_info_old_HDD_id_index
    on old_hdd_info (old_HDD_id);

create table rental
(
    rental_id    int auto_increment
        primary key,
    rental_date  date                                not null,
    inventory_id int                                 not null,
    customer_id  int                                 not null,
    return_date  date                                null,
    staff_id     int                                 not null,
    last_update  timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP
);

create index rental_customer_id_index
    on rental (customer_id);

create index rental_inventory_id_index
    on rental (inventory_id);

create index rental_staff_id_index
    on rental (staff_id);

create table rental_info_film
(
    rental_id   int                                 not null,
    film_id     int                                 not null,
    last_update timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    primary key (rental_id, film_id),
    constraint rental_info_film_film_film_id_fk
        foreign key (film_id) references film (film_id),
    constraint rental_info_film_rental_rental_id_fk
        foreign key (rental_id) references rental (rental_id)
);

create index rental_info_film_film_id_index
    on rental_info_film (film_id);

create index rental_info_film_rental_id_index
    on rental_info_film (rental_id);

create table rental_info_inventory
(
    rental_id    int                                 not null,
    inventory_id int                                 not null,
    last_update  timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    primary key (rental_id, inventory_id),
    constraint rental_info_inventory_inventory_inventory_id_fk
        foreign key (inventory_id) references inventory (inventory_id),
    constraint rental_info_inventory_rental_rental_id_fk
        foreign key (rental_id) references rental (rental_id)
);

create index rental_info_inventory_inventory_id_index
    on rental_info_inventory (inventory_id);

create index rental_info_inventory_rental_id_index
    on rental_info_inventory (rental_id);

create table staff
(
    staff_id    int auto_increment
        primary key,
    first_name  varchar(45)                         not null,
    last_name   varchar(45)                         not null,
    address_id  int                                 not null,
    email       varchar(50)                         null,
    active      tinyint(1)                          not null,
    username    varchar(50)                         not null,
    password    varchar(40)                         not null,
    last_update timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    constraint staff_address_address_id_fk
        foreign key (address_id) references address (address_id)
            on update cascade on delete cascade
);

create table rental_info
(
    rental_id   int                                 not null
        primary key,
    customer_id int                                 not null,
    staff_id    int                                 not null,
    rental_date date                                not null,
    return_date date                                null,
    last_update timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    constraint rental_info_staff_staff_id_fk
        foreign key (staff_id) references staff (staff_id)
);

create index rental_info_customer_id_index
    on rental_info (customer_id);

create index rental_info_staff_id_index
    on rental_info (staff_id);

create index staff_address_id_index
    on staff (address_id);

create table store
(
    store_id         int auto_increment
        primary key,
    manager_staff_id int                                 not null,
    address_id       int                                 not null,
    last_update      timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP
);

create table customer
(
    customer_id int auto_increment
        primary key,
    store_id    int                                 not null,
    first_name  varchar(45)                         not null,
    last_name   varchar(45)                         not null,
    address_id  int                                 not null,
    active      tinyint(1)                          not null,
    create_date date                                not null,
    last_update timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    constraint customer_address_address_id_fk
        foreign key (customer_id) references address (address_id)
            on update cascade on delete cascade,
    constraint customer_store_store_id_fk
        foreign key (store_id) references store (store_id)
);

create index customer_address_id_index
    on customer (address_id);

create index customer_store_id_index
    on customer (store_id);

create table staff_info
(
    staff_id    int                                 not null
        primary key,
    first_name  varchar(45)                         not null,
    last_name   varchar(45)                         not null,
    address_id  int                                 not null,
    email       varchar(50)                         not null,
    store_id    int                                 not null,
    active      tinyint(1)                          not null,
    username    varchar(16)                         not null,
    password    varchar(40)                         not null,
    last_update timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    constraint staff_info_address_address_id_fk
        foreign key (address_id) references address (address_id),
    constraint staff_info_store_store_id_fk
        foreign key (store_id) references store (store_id)
);

create index staff_info_address_id_index
    on staff_info (address_id);

create index staff_info_store_id_index
    on staff_info (store_id);

create table store_info
(
    store_id         int                                 not null
        primary key,
    manager_staff_id int                                 not null,
    address_id       int                                 not null,
    last_update      timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    constraint store_info_address_address_id_fk
        foreign key (address_id) references address (address_id),
    constraint store_info_staff_staff_id_fk
        foreign key (manager_staff_id) references staff (staff_id)
);

create index store_info_address_id_index
    on store_info (address_id);

create index store_info_manager_staff_id_index
    on store_info (manager_staff_id);

create table store_info_inventory
(
    store_id     int                                 not null,
    inventory_id int                                 not null,
    last_update  timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    primary key (store_id, inventory_id),
    constraint store_info_inventory_inventory_inventory_id_fk
        foreign key (inventory_id) references inventory (inventory_id),
    constraint store_info_inventory_store_store_id_fk
        foreign key (store_id) references store (store_id)
);

create index store_info_inventory_inventory_id_index
    on store_info_inventory (inventory_id);

create index store_info_inventory_store_id_index
    on store_info_inventory (store_id);

create table store_info_staff
(
    store_id    int                                 not null,
    staff_id    int                                 not null,
    last_update timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    primary key (store_id, staff_id),
    constraint store_info_staff_staff_staff_id_fk
        foreign key (staff_id) references staff (staff_id),
    constraint store_info_staff_store_store_id_fk
        foreign key (store_id) references store (store_id)
);

create index store_info_staff_staff_id_index
    on store_info_staff (staff_id);

create index store_info_staff_store_id_index
    on store_info_staff (store_id);

create table store_info_store
(
    store_id        int                                 not null,
    parent_store_id int                                 not null,
    last_update     timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    primary key (store_id, parent_store_id),
    constraint store_info_store_store_info_store_id_fk
        foreign key (parent_store_id) references store_info (store_id),
    constraint store_info_store_store_info_store_id_fk_2
        foreign key (store_id) references store_info (store_id)
);

create index store_info_store_store_id_index
    on store_info_store (store_id);

create index store_info_store_store_id_index_2
    on store_info_store (store_id);

create index store_info_store_store_id_index_3
    on store_info_store (store_id);


