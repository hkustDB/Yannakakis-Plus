create or replace view aggView8637734573772571819 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin3616039083741039828 as select movie_id as v23, v35 from movie_keyword as mk, aggView8637734573772571819 where mk.keyword_id=aggView8637734573772571819.v8;
create or replace view aggView307073142207780980 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin7448654676122322341 as select movie_id as v23, v36 from cast_info as ci, aggView307073142207780980 where ci.person_id=aggView307073142207780980.v14;
create or replace view aggView1593809644521921728 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin9196757147915890488 as select v23, v36, v37 from aggJoin7448654676122322341 join aggView1593809644521921728 using(v23);
create or replace view aggView8521341458439866934 as select v23, MIN(v35) as v35 from aggJoin3616039083741039828 group by v23,v35;
create or replace view aggJoin2080495551605040898 as select v36 as v36, v37 as v37, v35 from aggJoin9196757147915890488 join aggView8521341458439866934 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin2080495551605040898;
