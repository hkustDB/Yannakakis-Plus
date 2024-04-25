create or replace view aggView7727647927801619843 as select production_year as v19, id as v15, title as v16 from title as t;
create or replace view aggJoin7362212868483676083 as (
with aggView631360544128907149 as (select id as v3 from info_type as it where info= 'top 250 rank')
select movie_id as v15 from movie_info_idx as mi_idx, aggView631360544128907149 where mi_idx.info_type_id=aggView631360544128907149.v3);
create or replace view aggJoin6429624868532300930 as (
with aggView5283968505037493319 as (select v15 from aggJoin7362212868483676083 group by v15)
select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView5283968505037493319 where mc.movie_id=aggView5283968505037493319.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%')));
create or replace view aggJoin8879068116499064324 as (
with aggView3122623922523511430 as (select id as v1 from company_type as ct where kind= 'production companies')
select v15, v9 from aggJoin6429624868532300930 join aggView3122623922523511430 using(v1));
create or replace view aggView4487512139833239980 as select v15, v9 from aggJoin8879068116499064324 group by v15,v9;
create or replace view aggJoin2347499049632055761 as (
with aggView4479369542597990481 as (select v15, MIN(v9) as v27 from aggView4487512139833239980 group by v15)
select v19, v16, v27 from aggView7727647927801619843 join aggView4479369542597990481 using(v15));
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin2347499049632055761;
