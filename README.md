PharmaTrack is a comprehensive relational database solution designed to manage the complex lifecycle of pharmaceutical distribution. This system bridges the gap between healthcare requirements and supply chain logistics by structuring how medicines are categorized by disease and tracked through a global inventory network.

The database is fully normalized to Third Normal Form (3NF) to ensure data integrity, reduce redundancy, and provide a "single source of truth" for regional sales and stock management.

🛠️ Technical Architecture
Schema Design: 3NF Relational Model

Core Logistics: Multi-tiered hierarchy (Region → Country → Location → Warehouse)

Inventory Management: M:N relationship resolution between warehouses and medicines.

Business Logic: Operational constraints including non-negative inventory levels and unique contact identification.

Tools Used: DbSchema (Modeling), SQL (PostgreSQL/SQL Server compatible).
