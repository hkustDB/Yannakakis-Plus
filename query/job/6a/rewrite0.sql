create or replace view aggView6816775584557866478 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin8254125934234974129 as select movie_id as v23, v35 from movie_keyword as mk, aggView6816775584557866478 where mk.keyword_id=aggView6816775584557866478.v8;
create or replace view aggView518735326028864570 as select v23, MIN(v35) as v35 from aggJoin8254125934234974129 group by v23;
create or replace view aggJoin7104215804881642758 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView518735326028864570 where t.id=aggView518735326028864570.v23 and production_year>2010;
create or replace view aggView4902322708691597675 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin7104215804881642758 group by v23;
create or replace view aggJoin649442683025769872 as select person_id as v14, v35, v37 from cast_info as ci, aggView4902322708691597675 where ci.movie_id=aggView4902322708691597675.v23;
create or replace view aggView1042044059848760005 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin649442683025769872 group by v14;
create or replace view aggJoin3741978725427806605 as select name as v15, v35, v37 from name as n, aggView1042044059848760005 where n.id=aggView1042044059848760005.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin3741978725427806605;
