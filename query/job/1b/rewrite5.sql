create or replace view aggJoin1826636576185143983 as (
with aggView850021984655779571 as (select id as v3 from info_type as it where info= 'bottom 10 rank')
select movie_id as v15 from movie_info_idx as mi_idx, aggView850021984655779571 where mi_idx.info_type_id=aggView850021984655779571.v3);
create or replace view aggJoin5165415387389830180 as (
with aggView6053973892872601235 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView6053973892872601235 where mc.company_type_id=aggView6053973892872601235.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%');
create or replace view aggJoin6159378199777192528 as (
with aggView7323431347004654000 as (select v15, MIN(v9) as v27 from aggJoin5165415387389830180 group by v15)
select id as v15, title as v16, production_year as v19, v27 from title as t, aggView7323431347004654000 where t.id=aggView7323431347004654000.v15 and production_year<=2010 and production_year>=2005);
create or replace view aggJoin2239212914387724994 as (
with aggView7835678596863032033 as (select v15, MIN(v27) as v27, MIN(v16) as v28, MIN(v19) as v29 from aggJoin6159378199777192528 group by v15,v27)
select v27, v28, v29 from aggJoin1826636576185143983 join aggView7835678596863032033 using(v15));
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin2239212914387724994;
