create or replace view aggJoin122455799840114432 as (
with aggView3713161087977593530 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v40, status_id as v7 from complete_cast as cc, aggView3713161087977593530 where cc.subject_id=aggView3713161087977593530.v5);
create or replace view aggJoin7499436149303484836 as (
with aggView4970477634985523549 as (select id as v31 from name as n)
select movie_id as v40, person_role_id as v9 from cast_info as ci, aggView4970477634985523549 where ci.person_id=aggView4970477634985523549.v31);
create or replace view aggJoin7149202803269333075 as (
with aggView6648149141113968236 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v40 from aggJoin122455799840114432 join aggView6648149141113968236 using(v7));
create or replace view aggJoin5340666314925290266 as (
with aggView1839637871863241129 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView1839637871863241129 where t.kind_id=aggView1839637871863241129.v26 and production_year>1950);
create or replace view aggJoin6887635708928981124 as (
with aggView525179508523279179 as (select v40, MIN(v41) as v52 from aggJoin5340666314925290266 group by v40)
select movie_id as v40, keyword_id as v23, v52 from movie_keyword as mk, aggView525179508523279179 where mk.movie_id=aggView525179508523279179.v40);
create or replace view aggJoin9007760317757848477 as (
with aggView1965799843751751604 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select v40 from aggJoin7499436149303484836 join aggView1965799843751751604 using(v9));
create or replace view aggJoin6791019099465428670 as (
with aggView5829930481119575693 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select v40, v52 from aggJoin6887635708928981124 join aggView5829930481119575693 using(v23));
create or replace view aggJoin7015639914539238932 as (
with aggView2058897064454192565 as (select v40, MIN(v52) as v52 from aggJoin6791019099465428670 group by v40,v52)
select v40, v52 from aggJoin7149202803269333075 join aggView2058897064454192565 using(v40));
create or replace view aggJoin556930602849646526 as (
with aggView4822099552875075280 as (select v40, MIN(v52) as v52 from aggJoin7015639914539238932 group by v40,v52)
select v52 from aggJoin9007760317757848477 join aggView4822099552875075280 using(v40));
select MIN(v52) as v52 from aggJoin556930602849646526;
