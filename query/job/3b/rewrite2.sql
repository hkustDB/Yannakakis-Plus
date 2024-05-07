create or replace view aggView8550089174469813936 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2400993610720904558 as select movie_id as v12 from movie_keyword as mk, aggView8550089174469813936 where mk.keyword_id=aggView8550089174469813936.v1;
create or replace view aggView7377427253235210257 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin8897912207415611167 as select v12 from aggJoin2400993610720904558 join aggView7377427253235210257 using(v12);
create or replace view aggView4546843961022868875 as select v12 from aggJoin8897912207415611167 group by v12;
create or replace view aggJoin1269699028017015103 as select title as v13, production_year as v16 from title as t, aggView4546843961022868875 where t.id=aggView4546843961022868875.v12 and production_year>2010;
create or replace view aggView233883205560315891 as select v13 from aggJoin1269699028017015103;
select MIN(v13) as v24 from aggView233883205560315891;
