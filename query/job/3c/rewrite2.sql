create or replace view aggView3928200068455701888 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin1008123386786464265 as select movie_id as v12, keyword_id as v1 from movie_keyword as mk, aggView3928200068455701888 where mk.movie_id=aggView3928200068455701888.v12;
create or replace view aggView1572097460982239686 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8624327149133843514 as select v12 from aggJoin1008123386786464265 join aggView1572097460982239686 using(v1);
create or replace view aggView7403939449047145083 as select v12 from aggJoin8624327149133843514 group by v12;
create or replace view aggJoin5298250615715426749 as select title as v13, production_year as v16 from title as t, aggView7403939449047145083 where t.id=aggView7403939449047145083.v12 and production_year>1990;
create or replace view aggView5467189935561013506 as select v13 from aggJoin5298250615715426749 group by v13;
select MIN(v13) as v24 from aggView5467189935561013506;
