# ECF induction and training record data prototype

This is a prototype demonstrating how we might store both induction records and training records in a way that:

* doesn't duplicate information
* is easy to query
* enables us to query a participant's state at any point in time
* allows us to build a picture of their training/induction history

## Reasoning

Given that:
  * an **induction period** requires an ECT to be associated with:
    - an appropriate body
    - a mentor
  * a **induction record** is made from a list of **induction periods**
  * an **training period** requires an ECT to be associated with:
    - a delivery partner and lead provider partnership
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
    cohorts {
        integer id PK
        integer year
    }

    appropriate_bodies {
        integer id PK
        character_varying name
    }

    appropriate_body_appointments {
        integer appropriate_body_id FK
        integer id PK
        integer participant_id FK
        date started_on
        date finished_on
    }

    provider_relationships {
        integer id PK
        integer delivery_partner_id FK
        integer lead_provider_id FK
        integer cohort_id FK
    }

    provider_materials {
        integer id PK
        character_varying name
    }
        
    training_courses {
        integer id PK
        character_varying training_type
        integer provider_relationship_id FK
        integer provider_materials_id FK
        integer participant_id FK
        date started_on
        date finished_on
    }

    delivery_partners {
        integer id PK
        character_varying name
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

    participants {
        integer id PK
        character_varying name
    }

    schools {
        integer id PK
        character_varying name
    }

    rosters {
        integer id PK
        integer participant_id FK
        integer school_id FK
        character_varying role
        date started_on
        date finished_on
    }

    appropriate_body_appointments }o--|| appropriate_bodies : "appropriate_body_id"
    appropriate_body_appointments }o--|| participants : "participant_id"

    mentorships }o--|| rosters : "mentee_id"
    mentorships }o--|| rosters : "mentor_id"
    rosters }o--|| participants : "participant_id"
    rosters }o--|| schools : "school_id"

    lead_providers ||--o{ provider_relationships : "lead_provider_id"
    delivery_partners ||--o{ provider_relationships : "delivery_partner_id"
    cohorts ||--o{ provider_relationships : "cohort_id"

    provider_relationships ||--o{ training_courses : "provider_relationships_id"
    provider_materials ||--o{ training_courses : "provider_materials_id"
    training_courses }o--|| participants : "participant_id"
```

