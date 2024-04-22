create or replace view aggJoin3202963399766369867 as (
with aggView5716904385531222371 as (select id as v1, name as v43 from char_name as chn)
select movie_id as v31, note as v12, role_id as v29, v43 from cast_info as ci, aggView5716904385531222371 where ci.person_role_id=aggView5716904385531222371.v1 and note LIKE '%(producer)%');
create or replace view aggJoin3152318092644189317 as (
with aggView79160938358979018 as (select id as v29 from role_type as rt where role= 'actor')
select v31, v12, v43 from aggJoin3202963399766369867 join aggView79160938358979018 using(v29));
create or replace view aggJoin7636524068217481083 as (
with aggView3682944301703167865 as (select v31, MIN(v43) as v43 from aggJoin3152318092644189317 group by v31,v43)
select id as v31, title as v32, production_year as v35, v43 from title as t, aggView3682944301703167865 where t.id=aggView3682944301703167865.v31 and production_year>2010);
create or replace view aggJoin5855645832197482506 as (
with aggView8000613924285836874 as (select v31, MIN(v43) as v43, MIN(v32) as v44 from aggJoin7636524068217481083 group by v31,v43)
select company_id as v15, company_type_id as v22, v43, v44 from movie_companies as mc, aggView8000613924285836874 where mc.movie_id=aggView8000613924285836874.v31);
create or replace view aggJoin2773912465732248528 as (
with aggView2680701870944834346 as (select id as v22 from company_type as ct)
select v15, v43, v44 from aggJoin5855645832197482506 join aggView2680701870944834346 using(v22));
create or replace view aggJoin623492374537314302 as (
with aggView664035424683749976 as (select id as v15 from company_name as cn where country_code= '[ru]')
select v43, v44 from aggJoin2773912465732248528 join aggView664035424683749976 using(v15));
select MIN(v43) as v43,MIN(v44) as v44 from aggJoin623492374537314302;
