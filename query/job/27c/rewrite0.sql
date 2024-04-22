create or replace view aggView808373145140260966 as select id as v25, name as v10 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]';
create or replace view aggJoin6432218862826973097 as (
with aggView8549139762851654312 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView8549139762851654312 where mk.keyword_id=aggView8549139762851654312.v35);
create or replace view aggJoin3185993002188945220 as (
with aggView374108069500951097 as (select movie_id as v37 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English') group by movie_id)
select id as v37, title as v41, production_year as v44 from title as t, aggView374108069500951097 where t.id=aggView374108069500951097.v37 and production_year>=1950 and production_year<=2010);
create or replace view aggJoin6530630724194747694 as (
with aggView7374726605831924883 as (select v37 from aggJoin6432218862826973097 group by v37)
select v37, v41, v44 from aggJoin3185993002188945220 join aggView7374726605831924883 using(v37));
create or replace view aggView7734316097190348048 as select v37, v41 from aggJoin6530630724194747694 group by v37,v41;
create or replace view aggJoin5127810212754417465 as (
with aggView6750990212227552039 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select movie_id as v37, v53 from movie_link as ml, aggView6750990212227552039 where ml.link_type_id=aggView6750990212227552039.v21);
create or replace view aggJoin1101004363246161974 as (
with aggView3005212460362117409 as (select v37, MIN(v41) as v54 from aggView7734316097190348048 group by v37)
select v37, v53 as v53, v54 from aggJoin5127810212754417465 join aggView3005212460362117409 using(v37));
create or replace view aggJoin1520554648793353617 as (
with aggView6894739988872405367 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView6894739988872405367 where cc.subject_id=aggView6894739988872405367.v5);
create or replace view aggJoin1505021713427980192 as (
with aggView4734143236906489757 as (select id as v7 from comp_cast_type as cct2 where kind LIKE 'complete%')
select v37 from aggJoin1520554648793353617 join aggView4734143236906489757 using(v7));
create or replace view aggJoin2956614887138510618 as (
with aggView6802002207070467689 as (select v37 from aggJoin1505021713427980192 group by v37)
select v37, v53 as v53, v54 as v54 from aggJoin1101004363246161974 join aggView6802002207070467689 using(v37));
create or replace view aggJoin6723713538420340913 as (
with aggView5477061289855901719 as (select v37, MIN(v53) as v53, MIN(v54) as v54 from aggJoin2956614887138510618 group by v37,v54,v53)
select company_id as v25, company_type_id as v26, v53, v54 from movie_companies as mc, aggView5477061289855901719 where mc.movie_id=aggView5477061289855901719.v37);
create or replace view aggJoin8438836041226112781 as (
with aggView7377839438787026449 as (select id as v26 from company_type as ct where kind= 'production companies')
select v25, v53, v54 from aggJoin6723713538420340913 join aggView7377839438787026449 using(v26));
create or replace view aggJoin2515634761169649519 as (
with aggView8774852968617432173 as (select v25, MIN(v53) as v53, MIN(v54) as v54 from aggJoin8438836041226112781 group by v25,v54,v53)
select v10, v53, v54 from aggView808373145140260966 join aggView8774852968617432173 using(v25));
select MIN(v10) as v52,MIN(v53) as v53,MIN(v54) as v54 from aggJoin2515634761169649519;
