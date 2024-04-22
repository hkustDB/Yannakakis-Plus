create or replace view aggView488734442426964287 as select name as v2, id as v1 from char_name as chn;
create or replace view aggView4254450650029716897 as select id as v31, title as v32 from title as t where production_year>2005;
create or replace view aggJoin2771628924394972581 as (
with aggView508265912414411881 as (select v1, MIN(v2) as v43 from aggView488734442426964287 group by v1)
select movie_id as v31, note as v12, role_id as v29, v43 from cast_info as ci, aggView508265912414411881 where ci.person_role_id=aggView508265912414411881.v1 and note LIKE '%(voice)%' and note LIKE '%(uncredited)%');
create or replace view aggJoin7390336727316067039 as (
with aggView321766214372741049 as (select id as v29 from role_type as rt where role= 'actor')
select v31, v12, v43 from aggJoin2771628924394972581 join aggView321766214372741049 using(v29));
create or replace view aggJoin3180201660218632992 as (
with aggView7730259545264576049 as (select id as v22 from company_type as ct)
select movie_id as v31, company_id as v15 from movie_companies as mc, aggView7730259545264576049 where mc.company_type_id=aggView7730259545264576049.v22);
create or replace view aggJoin3856582270849016867 as (
with aggView7270939662560047827 as (select id as v15 from company_name as cn where country_code= '[ru]')
select v31 from aggJoin3180201660218632992 join aggView7270939662560047827 using(v15));
create or replace view aggJoin7681114395308805562 as (
with aggView1345023653925347970 as (select v31 from aggJoin3856582270849016867 group by v31)
select v31, v12, v43 as v43 from aggJoin7390336727316067039 join aggView1345023653925347970 using(v31));
create or replace view aggJoin4854656899905512563 as (
with aggView1276092715760293548 as (select v31, MIN(v43) as v43 from aggJoin7681114395308805562 group by v31,v43)
select v32, v43 from aggView4254450650029716897 join aggView1276092715760293548 using(v31));
select MIN(v43) as v43,MIN(v32) as v44 from aggJoin4854656899905512563;
