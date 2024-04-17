create or replace view aggView4466357826771317822 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin6857663352262383852 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView4466357826771317822 where mk.movie_id=aggView4466357826771317822.v12;
create or replace view aggView7061762456986815695 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5432633381686356984 as select v12, v24 from aggJoin6857663352262383852 join aggView7061762456986815695 using(v1);
create or replace view aggView5294902650222769720 as select v12, MIN(v24) as v24 from aggJoin5432633381686356984 group by v12,v24;
create or replace view aggJoin4675045972580571063 as select v24 from movie_info as mi, aggView5294902650222769720 where mi.movie_id=aggView5294902650222769720.v12 and info= 'Bulgaria';
select MIN(v24) as v24 from aggJoin4675045972580571063;
