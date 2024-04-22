create or replace view aggJoin1433975100941081316 as (
with aggView9220472204258613587 as (select id as v1, name as v41 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView9220472204258613587 where mc.company_id=aggView9220472204258613587.v1);
create or replace view aggJoin4857991756553875175 as (
with aggView6882499133737842526 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView6882499133737842526 where mi.info_type_id=aggView6882499133737842526.v21 and info IN ('Drama','Horror'));
create or replace view aggJoin5362340567696002106 as (
with aggView8335653915549303277 as (select v29 from aggJoin4857991756553875175 group by v29)
select id as v29, title as v30, production_year as v33 from title as t, aggView8335653915549303277 where t.id=aggView8335653915549303277.v29 and production_year<=2008 and production_year>=2005);
create or replace view aggJoin1608309787862504849 as (
with aggView8670628611151270721 as (select v29, MIN(v30) as v43 from aggJoin5362340567696002106 group by v29)
select movie_id as v29, info_type_id as v26, info as v27, v43 from movie_info_idx as mi_idx, aggView8670628611151270721 where mi_idx.movie_id=aggView8670628611151270721.v29 and info>'8.0');
create or replace view aggJoin6337570220937630857 as (
with aggView1139466244881009719 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41 from aggJoin1433975100941081316 join aggView1139466244881009719 using(v8));
create or replace view aggJoin7532074247351785300 as (
with aggView1407655350801108306 as (select id as v26 from info_type as it2 where info= 'rating')
select v29, v27, v43 from aggJoin1608309787862504849 join aggView1407655350801108306 using(v26));
create or replace view aggJoin899822332232176060 as (
with aggView705804969763002661 as (select v29, MIN(v43) as v43, MIN(v27) as v42 from aggJoin7532074247351785300 group by v29,v43)
select v41 as v41, v43, v42 from aggJoin6337570220937630857 join aggView705804969763002661 using(v29));
select MIN(v41) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin899822332232176060;
