                         ┌──────────────────┐
                         │   Job Websites   │
                         │                  │
                         │ Indeed           │
                         │ RemoteOK         │
                         │ Company Careers  │
                         │ Other sources    │
                         └────────┬─────────┘
                                  │
                                  ▼
                         ┌──────────────────┐
                         │     Crawlers     │
                         └────────┬─────────┘
                                  │
                                  ▼
                         ┌──────────────────┐
                         │   Job Collector  │
                         └────────┬─────────┘
                                  │
                                  ▼
                         ┌──────────────────┐
                         │   PostgreSQL     │
                         │                  │
                         │ Jobs             │
                         │ Companies        │
                         │ Skills           │
                         └────────┬─────────┘
                                  │
                                  ▼
                         ┌──────────────────┐
                         │ Matching Engine  │
                         └────────┬─────────┘
                                  │
                         ┌────────┴────────┐
                         ▼                 ▼
                   ┌───────────┐     ┌───────────┐
                   │ Dashboard │     │   Email   │
                   └───────────┘     └───────────┘

Admin "Crawl now" → Crawler → Remotive API → JobImporter (dedup) → job_listings
                                                                      │
User favorites apartment → JobMatcher (near + fallback) ──────────────┤
                                                                      ▼
                                              Dashboard job list → SavedJob


rails smoke:jobs
── 1. Schema ──
✅ job_listings table
✅ url_digest unique index
✅ apartments table
✅ favorites table
── 2. Crawl (real API call) ──
✅ crawl session completed
✅ listings in DB (10 listings)
── 3. Dedup ──
✅ re-import does not duplicate
── 4. Match ──
✅ user exists
✅ apartment geocoded
✅ matcher returns jobs (5 jobs)
── 5. Save ──
✅ job saved

🎉 ALL CHECKS PASSED (10 listings, 1 saved)
