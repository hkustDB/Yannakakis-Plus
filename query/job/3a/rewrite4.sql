create or replace view aggView5168171800966622372 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin8089799287721555743 as select id as v12, title as v13, production_year as v16 from title as t, aggView5168171800966622372 where t.id=aggView5168171800966622372.v12 and production_year>2005;
create or replace view aggView4941747267213264198 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5028618306481408270 as select movie_id as v12 from movie_keyword as mk, aggView4941747267213264198 where mk.keyword_id=aggView4941747267213264198.v1;
create or replace view aggView4969309261275310184 as select v12, MIN(v13) as v24 from aggJoin8089799287721555743 group by v12;
create or replace view aggJoin6583179336628604755 as select v24 from aggJoin5028618306481408270 join aggView4969309261275310184 using(v12);
select MIN(v24) as v24 from aggJoin6583179336628604755;
