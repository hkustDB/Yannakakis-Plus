create or replace view aggView4385940707633079188 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin1505841650848571156 as select movie_id as v23, v35 from movie_keyword as mk, aggView4385940707633079188 where mk.keyword_id=aggView4385940707633079188.v8;
create or replace view aggView1661461623779466408 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin6996500418092028220 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView1661461623779466408 where ci.movie_id=aggView1661461623779466408.v23;
create or replace view aggView3017344548106113779 as select v23, MIN(v35) as v35 from aggJoin1505841650848571156 group by v23;
create or replace view aggJoin1566096263246283327 as select v14, v37 as v37, v35 from aggJoin6996500418092028220 join aggView3017344548106113779 using(v23);
create or replace view aggView2086344241426588378 as select v14, MIN(v37) as v37, MIN(v35) as v35 from aggJoin1566096263246283327 group by v14;
create or replace view aggJoin5945325878039886379 as select name as v15, v37, v35 from name as n, aggView2086344241426588378 where n.id=aggView2086344241426588378.v14;
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin5945325878039886379;
