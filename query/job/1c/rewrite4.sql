create or replace view aggView3490934478446995561 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin6466359790407893128 as select movie_id as v15 from movie_info_idx as mi_idx, aggView3490934478446995561 where mi_idx.info_type_id=aggView3490934478446995561.v3;
create or replace view aggView1659053252044620281 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8043997501429915603 as select movie_id as v15, note as v9 from movie_companies as mc, aggView1659053252044620281 where mc.company_type_id=aggView1659053252044620281.v1 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView5035246730871943112 as select v15, MIN(v9) as v27 from aggJoin8043997501429915603 group by v15;
create or replace view aggJoin152595298575327658 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView5035246730871943112 where t.id=aggView5035246730871943112.v15 and production_year>2010;
create or replace view aggView962512143269000177 as select v15, MIN(v27) as v27, MIN(v16) as v28, MIN(v19) as v29 from aggJoin152595298575327658 group by v15;
create or replace view aggJoin7745915087063102165 as select v27, v28, v29 from aggJoin6466359790407893128 join aggView962512143269000177 using(v15);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin7745915087063102165;
