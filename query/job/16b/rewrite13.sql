create or replace view aggJoin1155261299688623067 as (
with aggView6382312662912509687 as (select id as v11, title as v56 from title as t)
select movie_id as v11, keyword_id as v33, v56 from movie_keyword as mk, aggView6382312662912509687 where mk.movie_id=aggView6382312662912509687.v11);
create or replace view aggJoin3348908418959464963 as (
with aggView4633816418877016930 as (select person_id as v2, MIN(name) as v55 from aka_name as an group by person_id)
select person_id as v2, movie_id as v11, v55 from cast_info as ci, aggView4633816418877016930 where ci.person_id=aggView4633816418877016930.v2);
create or replace view aggJoin5536624251968922776 as (
with aggView6885769667601434917 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView6885769667601434917 where mc.company_id=aggView6885769667601434917.v28);
create or replace view aggJoin3087724346964018710 as (
with aggView4753256053253981213 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select v11, v56 from aggJoin1155261299688623067 join aggView4753256053253981213 using(v33));
create or replace view aggJoin5361544101847612042 as (
with aggView1176671153116909681 as (select id as v2 from name as n)
select v11, v55 from aggJoin3348908418959464963 join aggView1176671153116909681 using(v2));
create or replace view aggJoin2252227299857346202 as (
with aggView3415231987091001378 as (select v11 from aggJoin5536624251968922776 group by v11)
select v11, v56 as v56 from aggJoin3087724346964018710 join aggView3415231987091001378 using(v11));
create or replace view aggJoin33198639435145140 as (
with aggView7855295815576346574 as (select v11, MIN(v56) as v56 from aggJoin2252227299857346202 group by v11,v56)
select v55 as v55, v56 from aggJoin5361544101847612042 join aggView7855295815576346574 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin33198639435145140;
