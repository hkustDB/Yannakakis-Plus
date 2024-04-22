create or replace view aggJoin1865936790270536421 as (
with aggView3172678749963395688 as (select id as v11, title as v56 from title as t)
select movie_id as v11, company_id as v28, v56 from movie_companies as mc, aggView3172678749963395688 where mc.movie_id=aggView3172678749963395688.v11);
create or replace view aggJoin4257881064536008738 as (
with aggView8061970887763703809 as (select id as v28 from company_name as cn where country_code= '[us]')
select v11, v56 from aggJoin1865936790270536421 join aggView8061970887763703809 using(v28));
create or replace view aggJoin5696631148546265889 as (
with aggView6773604514179510912 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView6773604514179510912 where mk.keyword_id=aggView6773604514179510912.v33);
create or replace view aggJoin2430729157818428000 as (
with aggView2952548560452853335 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView2952548560452853335 where an.person_id=aggView2952548560452853335.v2);
create or replace view aggJoin1873364837238252556 as (
with aggView3287946447144793952 as (select v2, MIN(v3) as v55 from aggJoin2430729157818428000 group by v2)
select movie_id as v11, v55 from cast_info as ci, aggView3287946447144793952 where ci.person_id=aggView3287946447144793952.v2);
create or replace view aggJoin1591803719535519510 as (
with aggView7156644143866323101 as (select v11 from aggJoin5696631148546265889 group by v11)
select v11, v55 as v55 from aggJoin1873364837238252556 join aggView7156644143866323101 using(v11));
create or replace view aggJoin5513684859946476738 as (
with aggView8254856615397839012 as (select v11, MIN(v56) as v56 from aggJoin4257881064536008738 group by v11,v56)
select v55 as v55, v56 from aggJoin1591803719535519510 join aggView8254856615397839012 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin5513684859946476738;
