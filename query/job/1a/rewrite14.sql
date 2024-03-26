create or replace view aggView3037518981186827644 as select id as v15, title as v28, production_year as v29 from title as t;
create or replace view aggJoin8412500701744701052 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView3037518981186827644 where mc.movie_id=aggView3037518981186827644.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView5621609494858088897 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin1763395210193879595 as select movie_id as v15 from movie_info_idx as mi_idx, aggView5621609494858088897 where mi_idx.info_type_id=aggView5621609494858088897.v3;
create or replace view aggView7335894463893842029 as select v15 from aggJoin1763395210193879595 group by v15;
create or replace view aggJoin404034347178620853 as select v1, v9, v28 as v28, v29 as v29 from aggJoin8412500701744701052 join aggView7335894463893842029 using(v15);
create or replace view aggView3600378109489903793 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6675152806641704085 as select v9, v28, v29 from aggJoin404034347178620853 join aggView3600378109489903793 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin6675152806641704085;
