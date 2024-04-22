create or replace view aggJoin4055635960149275781 as (
with aggView7870965660485081158 as (select id as v3 from info_type as it)
select movie_id as v15, info as v13 from movie_info as mi, aggView7870965660485081158 where mi.info_type_id=aggView7870965660485081158.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin8163250295570356773 as (
with aggView5549971756817762079 as (select v15 from aggJoin4055635960149275781 group by v15)
select id as v15, title as v16, production_year as v19 from title as t, aggView5549971756817762079 where t.id=aggView5549971756817762079.v15 and production_year>1990);
create or replace view aggJoin6578073858591873001 as (
with aggView6717589834560958453 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView6717589834560958453 where mc.company_type_id=aggView6717589834560958453.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%');
create or replace view aggJoin4825632159510860299 as (
with aggView7960283399071521027 as (select v15 from aggJoin6578073858591873001 group by v15)
select v16, v19 from aggJoin8163250295570356773 join aggView7960283399071521027 using(v15));
create or replace view aggView3656822563629845890 as select v16 from aggJoin4825632159510860299 group by v16;
select MIN(v16) as v27 from aggView3656822563629845890;
