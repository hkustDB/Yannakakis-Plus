create or replace view aggJoin8475897588389648599 as (
with aggView1404467403819636017 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView1404467403819636017 where mc.company_id=aggView1404467403819636017.v13);
create or replace view aggJoin4445196745819970392 as (
with aggView5303362044457834899 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, note as v36 from movie_info as mi, aggView5303362044457834899 where mi.info_type_id=aggView5303362044457834899.v22 and note LIKE '%internet%');
create or replace view aggJoin4645424074470240790 as (
with aggView3862724020291438037 as (select v40 from aggJoin4445196745819970392 group by v40)
select id as v40, title as v41, production_year as v44 from title as t, aggView3862724020291438037 where t.id=aggView3862724020291438037.v40 and production_year>1990);
create or replace view aggJoin2486920574191256165 as (
with aggView2977795866979911124 as (select id as v20 from company_type as ct)
select v40 from aggJoin8475897588389648599 join aggView2977795866979911124 using(v20));
create or replace view aggJoin2065246992636548727 as (
with aggView2345169087995462565 as (select v40 from aggJoin2486920574191256165 group by v40)
select movie_id as v40, title as v3 from aka_title as aka_t, aggView2345169087995462565 where aka_t.movie_id=aggView2345169087995462565.v40);
create or replace view aggView723496414265252637 as select v40, v3 from aggJoin2065246992636548727 group by v40,v3;
create or replace view aggJoin189774873640026105 as (
with aggView8953119541993736003 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView8953119541993736003 where mk.keyword_id=aggView8953119541993736003.v24);
create or replace view aggJoin8751298979279937637 as (
with aggView4947196776583038022 as (select v40 from aggJoin189774873640026105 group by v40)
select v40, v41, v44 from aggJoin4645424074470240790 join aggView4947196776583038022 using(v40));
create or replace view aggView9128953224696412225 as select v40, v41 from aggJoin8751298979279937637 group by v40,v41;
create or replace view aggJoin4478230626844686330 as (
with aggView48377796603720539 as (select v40, MIN(v3) as v52 from aggView723496414265252637 group by v40)
select v41, v52 from aggView9128953224696412225 join aggView48377796603720539 using(v40));
select MIN(v52) as v52,MIN(v41) as v53 from aggJoin4478230626844686330;
