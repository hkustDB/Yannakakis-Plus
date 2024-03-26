create or replace view aggView1729451565787479484 as select id as v12, title as v31 from title as t;
create or replace view aggJoin6270447130863611032 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView1729451565787479484 where mk.movie_id=aggView1729451565787479484.v12;
create or replace view aggView8321504974349890106 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin8559823790270771101 as select v12, v31 from aggJoin6270447130863611032 join aggView8321504974349890106 using(v18);
create or replace view aggView2505626489902737916 as select v12, MIN(v31) as v31 from aggJoin8559823790270771101 group by v12;
create or replace view aggJoin5733347819845442467 as select company_id as v1, v31 from movie_companies as mc, aggView2505626489902737916 where mc.movie_id=aggView2505626489902737916.v12;
create or replace view aggView4124682956849107541 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin1316804647843612035 as select v31 from aggJoin5733347819845442467 join aggView4124682956849107541 using(v1);
select MIN(v31) as v31 from aggJoin1316804647843612035;
