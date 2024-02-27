# ECF induction and training record data prototype

This is a prototype demonstrating how we might store both induction records and training records in a way that:

* doesn't duplicate information
* is easy to query
* enables us to query a person's state at any point in time
* allows us to build a picture of their training/induction history

## Reasoning

Given that:
  * an **induction period** requires an ECT to be associated with:
    - an appropriate body
    - a mentor
  * a **induction record** is made from a list of **induction periods**
  * an **training period** requires an ECT to be associated with:
    - a delivery partner
    - a lead provider
    - a mentor
  * a **training record** is made from a list of **training periods**

If we model **training periods** and **induction periods** as records, each
with foreign keys to the things that they depend on, what do incpomplete
periods look like? For example, if a ECT has an appropriate body but no mentor?

We could allow for a nullable `mentorship_id` field, but then it's not _really_
an induction period, so we'd introduce complexity elsewhere in the form of
scopes or functions to filter complete from incomplete periods.

Solving the problems without code is best by every measure, so if we model the
database so the facts are independently stored the resulting solution will
likely be easier to work with.

## Schema

```mermaid
erDiagram
    appropriate_bodies {
        integer id PK
        character_varying name
    }

    appropriate_body_appointments {
        integer appropriate_body_id FK
        integer id PK
        integer person_id FK
    }

    delivery_partner_associations {
        integer delivery_partner_id FK
        integer id PK
        integer person_id FK
    }

    delivery_partners {
        integer id PK
        character_varying name
    }

    lead_provider_associations {
        integer id PK
        integer lead_provider_id FK
        integer person_id FK
    }

    lead_providers {
        integer id PK
        character_varying name
    }

    mentorships {
        date finished_on
        integer id PK
        integer mentee_id FK
        integer mentor_id FK
        date started_on
    }

    people {
        integer id PK
        character_varying name
    }

    schools {
        integer id PK
        character_varying name
    }

    tenureships {
        date finished_on
        integer id PK
        integer person_id FK
        integer school_id FK
        date started_on
    }

    appropriate_body_appointments }o--|| appropriate_bodies : "appropriate_body_id"
    appropriate_body_appointments }o--|| people : "person_id"
    delivery_partner_associations }o--|| delivery_partners : "delivery_partner_id"
    delivery_partner_associations }o--|| people : "person_id"
    lead_provider_associations }o--|| lead_providers : "lead_provider_id"
    lead_provider_associations }o--|| people : "person_id"
    mentorships }o--|| tenureships : "mentee_id"
    mentorships }o--|| tenureships : "mentor_id"
    tenureships }o--|| people : "person_id"
    tenureships }o--|| schools : "school_id"
```
