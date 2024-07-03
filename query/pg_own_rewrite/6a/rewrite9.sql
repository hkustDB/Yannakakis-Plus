create or replace view aggView750293222658099622 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin3237737228416701714 as select movie_id as v23, v35 from movie_keyword as mk, aggView750293222658099622 where mk.keyword_id=aggView750293222658099622.v8;
create or replace view aggView5834777557104596112 as select id as v23, title as v37 from title as t where production_year>2010;
create or replace view aggJoin4265039233647059295 as select v23, v35, v37 from aggJoin3237737228416701714 join aggView5834777557104596112 using(v23);
create or replace view aggView2178093968665922501 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin204425607271856100 as select movie_id as v23, v36 from cast_info as ci, aggView2178093968665922501 where ci.person_id=aggView2178093968665922501.v14;
create or replace view aggView8307663634909623297 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin4265039233647059295 group by v23,v35,v37;
create or replace view aggJoin36401645271835978 as select v36 as v36, v35, v37 from aggJoin204425607271856100 join aggView8307663634909623297 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin36401645271835978;
