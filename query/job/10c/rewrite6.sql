create or replace view aggJoin1272741750207527742 as (
with aggView3822610922167340263 as (select id as v31, title as v44 from title as t where production_year>1990)
select movie_id as v31, company_id as v15, company_type_id as v22, v44 from movie_companies as mc, aggView3822610922167340263 where mc.movie_id=aggView3822610922167340263.v31);
create or replace view aggJoin595340490774004287 as (
with aggView8523724459474127245 as (select id as v22 from company_type as ct)
select v31, v15, v44 from aggJoin1272741750207527742 join aggView8523724459474127245 using(v22));
create or replace view aggJoin3705987643458476651 as (
with aggView4621249354354269148 as (select id as v29 from role_type as rt)
select movie_id as v31, person_role_id as v1, note as v12 from cast_info as ci, aggView4621249354354269148 where ci.role_id=aggView4621249354354269148.v29 and note LIKE '%(producer)%');
create or replace view aggJoin9045502871785528659 as (
with aggView8927892694013586693 as (select id as v15 from company_name as cn where country_code= '[us]')
select v31, v44 from aggJoin595340490774004287 join aggView8927892694013586693 using(v15));
create or replace view aggJoin4326784473599030526 as (
with aggView3998487954983855949 as (select v31, MIN(v44) as v44 from aggJoin9045502871785528659 group by v31,v44)
select v1, v12, v44 from aggJoin3705987643458476651 join aggView3998487954983855949 using(v31));
create or replace view aggJoin6201922759128929472 as (
with aggView2961179820781192059 as (select v1, MIN(v44) as v44 from aggJoin4326784473599030526 group by v1,v44)
select name as v2, v44 from char_name as chn, aggView2961179820781192059 where chn.id=aggView2961179820781192059.v1);
select MIN(v2) as v43,MIN(v44) as v44 from aggJoin6201922759128929472;
