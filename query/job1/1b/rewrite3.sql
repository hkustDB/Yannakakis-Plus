create or replace view aggView261391337244064551 as select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin1213831850743154557 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView261391337244064551 where mi_idx.movie_id=aggView261391337244064551.v15;
create or replace view aggView3441927229247294029 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5839190472224359754 as select movie_id as v15, note as v9 from movie_companies as mc, aggView3441927229247294029 where mc.company_type_id=aggView3441927229247294029.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView7113583407808769769 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin1127877393789988208 as select v15, v28, v29 from aggJoin1213831850743154557 join aggView7113583407808769769 using(v3);
create or replace view aggView4498181071524471660 as select v15, MIN(v28) as v28, MIN(v29) as v29 from aggJoin1127877393789988208 group by v15;
create or replace view aggJoin7756550697570820899 as select v9, v28, v29 from aggJoin5839190472224359754 join aggView4498181071524471660 using(v15);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin7756550697570820899;
