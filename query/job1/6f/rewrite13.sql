create or replace view aggView1229060114224223180 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin3526838590623490021 as select movie_id as v23, v35 from movie_keyword as mk, aggView1229060114224223180 where mk.keyword_id=aggView1229060114224223180.v8;
create or replace view aggView2215379523719148210 as select id as v14, name as v36 from name as n;
create or replace view aggJoin6886107810370712969 as select movie_id as v23, v36 from cast_info as ci, aggView2215379523719148210 where ci.person_id=aggView2215379523719148210.v14;
create or replace view aggView64481944857403725 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin8581549990667273316 as select v23, v36, v37 from aggJoin6886107810370712969 join aggView64481944857403725 using(v23);
create or replace view aggView2948913548442918188 as select v23, MIN(v35) as v35 from aggJoin3526838590623490021 group by v23;
create or replace view aggJoin2145190600535091750 as select v36 as v36, v37 as v37, v35 from aggJoin8581549990667273316 join aggView2948913548442918188 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin2145190600535091750;
