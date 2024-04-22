create or replace view aggJoin6163126745116309015 as (
with aggView5951065501016189822 as (select id as v31, title as v44 from title as t where production_year>2010)
select movie_id as v31, company_id as v15, company_type_id as v22, v44 from movie_companies as mc, aggView5951065501016189822 where mc.movie_id=aggView5951065501016189822.v31);
create or replace view aggJoin4511533795271249378 as (
with aggView5590448180359220487 as (select id as v29 from role_type as rt where role= 'actor')
select movie_id as v31, person_role_id as v1, note as v12 from cast_info as ci, aggView5590448180359220487 where ci.role_id=aggView5590448180359220487.v29 and note LIKE '%(producer)%');
create or replace view aggJoin3324744719473730385 as (
with aggView5165543909848044783 as (select id as v22 from company_type as ct)
select v31, v15, v44 from aggJoin6163126745116309015 join aggView5165543909848044783 using(v22));
create or replace view aggJoin9062734315302184144 as (
with aggView2651028691146489599 as (select id as v15 from company_name as cn where country_code= '[ru]')
select v31, v44 from aggJoin3324744719473730385 join aggView2651028691146489599 using(v15));
create or replace view aggJoin4706403654928473520 as (
with aggView8716907936059439758 as (select v31, MIN(v44) as v44 from aggJoin9062734315302184144 group by v31,v44)
select v1, v12, v44 from aggJoin4511533795271249378 join aggView8716907936059439758 using(v31));
create or replace view aggJoin5504897258458335934 as (
with aggView187292798890978211 as (select v1, MIN(v44) as v44 from aggJoin4706403654928473520 group by v1,v44)
select name as v2, v44 from char_name as chn, aggView187292798890978211 where chn.id=aggView187292798890978211.v1);
select MIN(v2) as v43,MIN(v44) as v44 from aggJoin5504897258458335934;
