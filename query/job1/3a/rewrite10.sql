create or replace view aggView7493066401119627959 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin2584188569479809111 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView7493066401119627959 where mk.movie_id=aggView7493066401119627959.v12;
create or replace view aggView4008955059278777440 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1794692595124712598 as select v12, v24 from aggJoin2584188569479809111 join aggView4008955059278777440 using(v1);
create or replace view aggView5955372722928107145 as select v12, MIN(v24) as v24 from aggJoin1794692595124712598 group by v12;
create or replace view aggJoin4160275569250401378 as select info as v7, v24 from movie_info as mi, aggView5955372722928107145 where mi.movie_id=aggView5955372722928107145.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
select MIN(v24) as v24 from aggJoin4160275569250401378;
