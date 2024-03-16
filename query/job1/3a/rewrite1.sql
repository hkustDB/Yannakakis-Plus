create or replace view aggView5238551129575909694 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3896813910687772066 as select movie_id as v12 from movie_keyword as mk, aggView5238551129575909694 where mk.keyword_id=aggView5238551129575909694.v1;
create or replace view aggView6079053613441557457 as select v12 from aggJoin3896813910687772066 group by v12;
create or replace view aggJoin3680928173932329929 as select movie_id as v12, info as v7 from movie_info as mi, aggView6079053613441557457 where mi.movie_id=aggView6079053613441557457.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView802351441062595057 as select v12 from aggJoin3680928173932329929 group by v12;
create or replace view aggJoin5056277936842175324 as select title as v13 from title as t, aggView802351441062595057 where t.id=aggView802351441062595057.v12 and production_year>2005;
select MIN(v13) as v24 from aggJoin5056277936842175324;
