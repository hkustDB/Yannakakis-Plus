create or replace view aggJoin4907302144948908919 as (
with aggView2416249979621454475 as (select id as v29 from role_type as rt where role= 'actor')
select movie_id as v31, person_role_id as v1, note as v12 from cast_info as ci, aggView2416249979621454475 where ci.role_id=aggView2416249979621454475.v29 and note LIKE '%(producer)%');
create or replace view aggJoin3886539208725635853 as (
with aggView149283290328449973 as (select id as v22 from company_type as ct)
select movie_id as v31, company_id as v15 from movie_companies as mc, aggView149283290328449973 where mc.company_type_id=aggView149283290328449973.v22);
create or replace view aggJoin7001955911047551326 as (
with aggView7210494555091467975 as (select id as v15 from company_name as cn where country_code= '[ru]')
select v31 from aggJoin3886539208725635853 join aggView7210494555091467975 using(v15));
create or replace view aggJoin5353385406859008016 as (
with aggView8901415606438413907 as (select v31 from aggJoin7001955911047551326 group by v31)
select id as v31, title as v32, production_year as v35 from title as t, aggView8901415606438413907 where t.id=aggView8901415606438413907.v31 and production_year>2010);
create or replace view aggJoin4135644801087309671 as (
with aggView7240852104865103961 as (select v31, MIN(v32) as v44 from aggJoin5353385406859008016 group by v31)
select v1, v12, v44 from aggJoin4907302144948908919 join aggView7240852104865103961 using(v31));
create or replace view aggJoin809595178056045998 as (
with aggView6327575071401893500 as (select v1, MIN(v44) as v44 from aggJoin4135644801087309671 group by v1,v44)
select name as v2, v44 from char_name as chn, aggView6327575071401893500 where chn.id=aggView6327575071401893500.v1);
select MIN(v2) as v43,MIN(v44) as v44 from aggJoin809595178056045998;
