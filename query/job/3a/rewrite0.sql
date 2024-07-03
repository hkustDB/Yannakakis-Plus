create or replace view aggView7363821121123859509 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3521605263042951824 as select movie_id as v12 from movie_keyword as mk, aggView7363821121123859509 where mk.keyword_id=aggView7363821121123859509.v1;
create or replace view aggView7247207262874111033 as select v12 from aggJoin3521605263042951824 group by v12;
create or replace view aggJoin7205605186990985988 as select id as v12, title as v13, production_year as v16 from title as t, aggView7247207262874111033 where t.id=aggView7247207262874111033.v12 and production_year>2005;
create or replace view aggView643109823695161791 as select v12, MIN(v13) as v24 from aggJoin7205605186990985988 group by v12;
create or replace view aggJoin3301016490210566515 as select info as v7, v24 from movie_info as mi, aggView643109823695161791 where mi.movie_id=aggView643109823695161791.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
select MIN(v24) as v24 from aggJoin3301016490210566515;
