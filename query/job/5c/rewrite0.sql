create or replace view aggJoin5133843880518073666 as (
with aggView7640914062958245181 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView7640914062958245181 where mc.company_type_id=aggView7640914062958245181.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%');
create or replace view aggJoin892780923123733065 as (
with aggView6468567959362925337 as (select id as v3 from info_type as it)
select movie_id as v15, info as v13 from movie_info as mi, aggView6468567959362925337 where mi.info_type_id=aggView6468567959362925337.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin2155255678317477609 as (
with aggView914868731727126684 as (select v15 from aggJoin5133843880518073666 group by v15)
select v15, v13 from aggJoin892780923123733065 join aggView914868731727126684 using(v15));
create or replace view aggJoin2896636447642759958 as (
with aggView4806323456081479415 as (select v15 from aggJoin2155255678317477609 group by v15)
select title as v16, production_year as v19 from title as t, aggView4806323456081479415 where t.id=aggView4806323456081479415.v15 and production_year>1990);
create or replace view aggView6007800759122762574 as select v16 from aggJoin2896636447642759958 group by v16;
select MIN(v16) as v27 from aggView6007800759122762574;
