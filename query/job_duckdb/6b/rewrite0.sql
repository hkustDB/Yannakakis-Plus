create or replace view aggView481383989373756585 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin6920440794156456576 as select movie_id as v23, v35 from movie_keyword as mk, aggView481383989373756585 where mk.keyword_id=aggView481383989373756585.v8;
create or replace view aggView2881451820917972088 as select v23, MIN(v35) as v35 from aggJoin6920440794156456576 group by v23;
create or replace view aggJoin610639115752190668 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView2881451820917972088 where t.id=aggView2881451820917972088.v23 and production_year>2014;
create or replace view aggView7233693538586740721 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin610639115752190668 group by v23;
create or replace view aggJoin579229048689911299 as select person_id as v14, v35, v37 from cast_info as ci, aggView7233693538586740721 where ci.movie_id=aggView7233693538586740721.v23;
create or replace view aggView3205310467970820196 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin1502499652594983133 as select v35, v37, v36 from aggJoin579229048689911299 join aggView3205310467970820196 using(v14);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1502499652594983133;
