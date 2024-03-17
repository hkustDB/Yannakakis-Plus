create or replace view aggView3381449044055495883 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin2319188072226603516 as select movie_id as v23, v35 from movie_keyword as mk, aggView3381449044055495883 where mk.keyword_id=aggView3381449044055495883.v8;
create or replace view aggView6770010438522894862 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin7433118005266914692 as select movie_id as v23, v36 from cast_info as ci, aggView6770010438522894862 where ci.person_id=aggView6770010438522894862.v14;
create or replace view aggView9053059904494538423 as select v23, MIN(v36) as v36 from aggJoin7433118005266914692 group by v23;
create or replace view aggJoin6917830039006551871 as select id as v23, title as v24, v36 from title as t, aggView9053059904494538423 where t.id=aggView9053059904494538423.v23 and production_year>2014;
create or replace view aggView515524496504095477 as select v23, MIN(v36) as v36, MIN(v24) as v37 from aggJoin6917830039006551871 group by v23;
create or replace view aggJoin4323745513340361609 as select v35 as v35, v36, v37 from aggJoin2319188072226603516 join aggView515524496504095477 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4323745513340361609;
