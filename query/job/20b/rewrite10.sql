create or replace view aggJoin666721984339474921 as (
with aggView6531631313546551192 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView6531631313546551192 where t.kind_id=aggView6531631313546551192.v26 and production_year>2000);
create or replace view aggJoin2019383003917556847 as (
with aggView42962416349060530 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select person_id as v31, movie_id as v40 from cast_info as ci, aggView42962416349060530 where ci.person_role_id=aggView42962416349060530.v9);
create or replace view aggJoin6601069941718453470 as (
with aggView8979831307034927 as (select id as v31 from name as n where name LIKE '%Downey%Robert%')
select v40 from aggJoin2019383003917556847 join aggView8979831307034927 using(v31));
create or replace view aggJoin7794477241105818726 as (
with aggView1145960234673643463 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView1145960234673643463 where cc.status_id=aggView1145960234673643463.v7);
create or replace view aggJoin5090458291411618877 as (
with aggView4837601783482280461 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin7794477241105818726 join aggView4837601783482280461 using(v5));
create or replace view aggJoin4293243819688360621 as (
with aggView8960088929887257917 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select movie_id as v40 from movie_keyword as mk, aggView8960088929887257917 where mk.keyword_id=aggView8960088929887257917.v23);
create or replace view aggJoin9111227805709292863 as (
with aggView4883170502831846550 as (select v40 from aggJoin4293243819688360621 group by v40)
select v40 from aggJoin5090458291411618877 join aggView4883170502831846550 using(v40));
create or replace view aggJoin2002298273951855194 as (
with aggView7588775484990380415 as (select v40 from aggJoin9111227805709292863 group by v40)
select v40, v41, v44 from aggJoin666721984339474921 join aggView7588775484990380415 using(v40));
create or replace view aggJoin8112428817236475088 as (
with aggView2157513770984826899 as (select v40, MIN(v41) as v52 from aggJoin2002298273951855194 group by v40)
select v52 from aggJoin6601069941718453470 join aggView2157513770984826899 using(v40));
select MIN(v52) as v52 from aggJoin8112428817236475088;
