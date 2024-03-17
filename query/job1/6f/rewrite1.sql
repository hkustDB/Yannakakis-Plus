create or replace view aggView7661781984380598899 as select id as v14, name as v36 from name as n;
create or replace view aggJoin2769306179306091959 as select movie_id as v23, v36 from cast_info as ci, aggView7661781984380598899 where ci.person_id=aggView7661781984380598899.v14;
create or replace view aggView4112173906127342037 as select v23, MIN(v36) as v36 from aggJoin2769306179306091959 group by v23;
create or replace view aggJoin3980302764419734837 as select id as v23, title as v24, v36 from title as t, aggView4112173906127342037 where t.id=aggView4112173906127342037.v23 and production_year>2000;
create or replace view aggView2177947525702512876 as select v23, MIN(v36) as v36, MIN(v24) as v37 from aggJoin3980302764419734837 group by v23;
create or replace view aggJoin6300508931516485503 as select keyword_id as v8, v36, v37 from movie_keyword as mk, aggView2177947525702512876 where mk.movie_id=aggView2177947525702512876.v23;
create or replace view aggView7391393061428328201 as select v8, MIN(v36) as v36, MIN(v37) as v37 from aggJoin6300508931516485503 group by v8;
create or replace view aggJoin3682222183314258007 as select keyword as v9, v36, v37 from keyword as k, aggView7391393061428328201 where k.id=aggView7391393061428328201.v8 and keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin3682222183314258007;
