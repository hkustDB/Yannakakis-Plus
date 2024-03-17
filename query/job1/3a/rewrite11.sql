create or replace view aggView7645327207452489221 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin3482536450712492036 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView7645327207452489221 where mk.movie_id=aggView7645327207452489221.v12;
create or replace view aggView6040770144409174362 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin4246598308706849655 as select v1, v24 as v24 from aggJoin3482536450712492036 join aggView6040770144409174362 using(v12);
create or replace view aggView7600071163178654069 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6010152335041008776 as select v24 from aggJoin4246598308706849655 join aggView7600071163178654069 using(v1);
select MIN(v24) as v24 from aggJoin6010152335041008776;
