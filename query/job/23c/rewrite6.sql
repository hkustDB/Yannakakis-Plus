create or replace view aggJoin5160277558320740739 as (
with aggView2974056627610101831 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView2974056627610101831 where mi.info_type_id=aggView2974056627610101831.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin8046109169436701862 as (
with aggView7115503654895854839 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView7115503654895854839 where mc.company_type_id=aggView7115503654895854839.v14);
create or replace view aggJoin7600702520893774927 as (
with aggView5113176674150838134 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView5113176674150838134 where mk.keyword_id=aggView5113176674150838134.v18);
create or replace view aggJoin5912717809950490213 as (
with aggView4730964867209559435 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin8046109169436701862 join aggView4730964867209559435 using(v7));
create or replace view aggJoin2561233004936644732 as (
with aggView4495105098592603744 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView4495105098592603744 where cc.status_id=aggView4495105098592603744.v5);
create or replace view aggJoin1499476270384394928 as (
with aggView6368918019764474764 as (select v36 from aggJoin5160277558320740739 group by v36)
select v36 from aggJoin5912717809950490213 join aggView6368918019764474764 using(v36));
create or replace view aggJoin6265589399571625754 as (
with aggView6269898026259094790 as (select v36 from aggJoin1499476270384394928 group by v36)
select v36 from aggJoin2561233004936644732 join aggView6269898026259094790 using(v36));
create or replace view aggJoin8931863320633311283 as (
with aggView8088054829947531883 as (select v36 from aggJoin7600702520893774927 group by v36)
select id as v36, title as v37, kind_id as v21, production_year as v40 from title as t, aggView8088054829947531883 where t.id=aggView8088054829947531883.v36 and production_year>1990);
create or replace view aggJoin3122930743217869678 as (
with aggView8377044262525784497 as (select v36 from aggJoin6265589399571625754 group by v36)
select v37, v21, v40 from aggJoin8931863320633311283 join aggView8377044262525784497 using(v36));
create or replace view aggView8854961108086079370 as select v37, v21 from aggJoin3122930743217869678 group by v37,v21;
create or replace view aggJoin4624761632729035095 as (
with aggView8944117238161959957 as (select id as v21, kind as v48 from kind_type as kt where kind IN ('movie','tv movie','video movie','video game'))
select v37, v48 from aggView8854961108086079370 join aggView8944117238161959957 using(v21));
select MIN(v48) as v48,MIN(v37) as v49 from aggJoin4624761632729035095;
