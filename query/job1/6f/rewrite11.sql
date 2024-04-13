create or replace view aggView7845997219365729691 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin3459691885541191440 as select movie_id as v23, v35 from movie_keyword as mk, aggView7845997219365729691 where mk.keyword_id=aggView7845997219365729691.v8;
create or replace view aggView3138883488398077121 as select id as v14, name as v36 from name as n;
create or replace view aggJoin3113595889840727452 as select movie_id as v23, v36 from cast_info as ci, aggView3138883488398077121 where ci.person_id=aggView3138883488398077121.v14;
create or replace view aggView4678041241917445061 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin8030284054086881512 as select v23, v36, v37 from aggJoin3113595889840727452 join aggView4678041241917445061 using(v23);
create or replace view aggView2118397445476955500 as select v23, MIN(v35) as v35 from aggJoin3459691885541191440 group by v23,v35;
create or replace view aggJoin7943145381519421598 as select v36 as v36, v37 as v37, v35 from aggJoin8030284054086881512 join aggView2118397445476955500 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin7943145381519421598;
