create or replace view aggJoin209155430449061005 as (
with aggView2823547184309518668 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView2823547184309518668 where mc.company_type_id=aggView2823547184309518668.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%');
create or replace view aggJoin4500732781589341137 as (
with aggView8870541840664293831 as (select id as v3 from info_type as it)
select movie_id as v15, info as v13 from movie_info as mi, aggView8870541840664293831 where mi.info_type_id=aggView8870541840664293831.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German'));
create or replace view aggJoin8506894706048289584 as (
with aggView4325906450586206204 as (select v15 from aggJoin4500732781589341137 group by v15)
select id as v15, title as v16, production_year as v19 from title as t, aggView4325906450586206204 where t.id=aggView4325906450586206204.v15 and production_year>2005);
create or replace view aggJoin1463416157862795353 as (
with aggView1401131991832957912 as (select v15 from aggJoin209155430449061005 group by v15)
select v16, v19 from aggJoin8506894706048289584 join aggView1401131991832957912 using(v15));
create or replace view aggView7835799214579388274 as select v16 from aggJoin1463416157862795353 group by v16;
select MIN(v16) as v27 from aggView7835799214579388274;
