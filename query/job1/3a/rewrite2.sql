create or replace view aggView6297598076132560746 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5058152236583156687 as select movie_id as v12 from movie_keyword as mk, aggView6297598076132560746 where mk.keyword_id=aggView6297598076132560746.v1;
create or replace view aggView7065719901367276959 as select v12 from aggJoin5058152236583156687 group by v12;
create or replace view aggJoin4278757190040201346 as select id as v12, title as v13, production_year as v16 from title as t, aggView7065719901367276959 where t.id=aggView7065719901367276959.v12 and production_year>2005;
create or replace view aggView1677590889225712282 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin6502880498652248548 as select v13, v16 from aggJoin4278757190040201346 join aggView1677590889225712282 using(v12);
create or replace view aggView9059364828212405518 as select v13 from aggJoin6502880498652248548 group by v13;
select min(v13) as v24 from aggView9059364828212405518;
