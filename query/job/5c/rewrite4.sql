create or replace view aggJoin7981255399947589409 as (
with aggView3780165644932781164 as (select id as v3 from info_type as it)
select movie_id as v15, info as v13 from movie_info as mi, aggView3780165644932781164 where mi.info_type_id=aggView3780165644932781164.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin7656236080451198296 as (
with aggView4603057472338832545 as (select v15 from aggJoin7981255399947589409 group by v15)
select id as v15, title as v16, production_year as v19 from title as t, aggView4603057472338832545 where t.id=aggView4603057472338832545.v15 and production_year>1990);
create or replace view aggJoin7750114035258670987 as (
with aggView6637508991868838872 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView6637508991868838872 where mc.company_type_id=aggView6637508991868838872.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%');
create or replace view aggJoin4471375327534736647 as (
with aggView8831673259161170809 as (select v15 from aggJoin7750114035258670987 group by v15)
select v16 from aggJoin7656236080451198296 join aggView8831673259161170809 using(v15));
select MIN(v16) as v27 from aggJoin4471375327534736647;
