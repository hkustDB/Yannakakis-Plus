create or replace view aggView7816696965203471061 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin7236900383682741566 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView7816696965203471061 where mk.movie_id=aggView7816696965203471061.v12;
create or replace view aggView2317317164055307811 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2570819997446969336 as select v12, v24 from aggJoin7236900383682741566 join aggView2317317164055307811 using(v1);
create or replace view aggView3548893927594250866 as select v12, MIN(v24) as v24 from aggJoin2570819997446969336 group by v12;
create or replace view aggJoin8307241893601592203 as select info as v7, v24 from movie_info as mi, aggView3548893927594250866 where mi.movie_id=aggView3548893927594250866.v12 and info= 'Bulgaria';
select MIN(v24) as v24 from aggJoin8307241893601592203;
