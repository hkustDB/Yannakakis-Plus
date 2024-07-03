create or replace view aggView6714635949487042621 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin1992129846712658155 as select movie_id as v23, v35 from movie_keyword as mk, aggView6714635949487042621 where mk.keyword_id=aggView6714635949487042621.v8;
create or replace view aggView173427549032329377 as select v23, MIN(v35) as v35 from aggJoin1992129846712658155 group by v23,v35;
create or replace view aggJoin6463343228020631499 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView173427549032329377 where t.id=aggView173427549032329377.v23 and production_year>2000;
create or replace view aggView748414650946732266 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin6463343228020631499 group by v23,v35;
create or replace view aggJoin9061159492147740764 as select person_id as v14, v35, v37 from cast_info as ci, aggView748414650946732266 where ci.movie_id=aggView748414650946732266.v23;
create or replace view aggView2812301660213366413 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8136217308635201729 as select v35, v37, v36 from aggJoin9061159492147740764 join aggView2812301660213366413 using(v14);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin8136217308635201729;
