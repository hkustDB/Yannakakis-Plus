create or replace view aggView4822631059699603243 as select name as v2, id as v1 from char_name as chn;
create or replace view aggJoin4241819648862060471 as (
with aggView6012844906120309627 as (select id as v22 from company_type as ct)
select movie_id as v31, company_id as v15 from movie_companies as mc, aggView6012844906120309627 where mc.company_type_id=aggView6012844906120309627.v22);
create or replace view aggJoin1511907263524445967 as (
with aggView7901878625344966726 as (select id as v15 from company_name as cn where country_code= '[us]')
select v31 from aggJoin4241819648862060471 join aggView7901878625344966726 using(v15));
create or replace view aggJoin6481241228609625527 as (
with aggView7150113430948870356 as (select v31 from aggJoin1511907263524445967 group by v31)
select id as v31, title as v32, production_year as v35 from title as t, aggView7150113430948870356 where t.id=aggView7150113430948870356.v31 and production_year>1990);
create or replace view aggView8121574811373813812 as select v31, v32 from aggJoin6481241228609625527 group by v31,v32;
create or replace view aggJoin7688672177417566288 as (
with aggView6879874286951012562 as (select v1, MIN(v2) as v43 from aggView4822631059699603243 group by v1)
select movie_id as v31, note as v12, role_id as v29, v43 from cast_info as ci, aggView6879874286951012562 where ci.person_role_id=aggView6879874286951012562.v1 and note LIKE '%(producer)%');
create or replace view aggJoin717933505154407697 as (
with aggView2254498603064478853 as (select id as v29 from role_type as rt)
select v31, v12, v43 from aggJoin7688672177417566288 join aggView2254498603064478853 using(v29));
create or replace view aggJoin3656673611881206999 as (
with aggView2035278960157841921 as (select v31, MIN(v43) as v43 from aggJoin717933505154407697 group by v31,v43)
select v32, v43 from aggView8121574811373813812 join aggView2035278960157841921 using(v31));
select MIN(v43) as v43,MIN(v32) as v44 from aggJoin3656673611881206999;
