create or replace view aggView3417938930868016905 as select id as v12, title as v31 from title as t;
create or replace view aggJoin6541228102353807890 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView3417938930868016905 where mc.movie_id=aggView3417938930868016905.v12;
create or replace view aggView3855017947913106320 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin5841357404720088466 as select movie_id as v12 from movie_keyword as mk, aggView3855017947913106320 where mk.keyword_id=aggView3855017947913106320.v18;
create or replace view aggView7064056395320839295 as select v12 from aggJoin5841357404720088466 group by v12;
create or replace view aggJoin6950749849759908560 as select v1, v31 as v31 from aggJoin6541228102353807890 join aggView7064056395320839295 using(v12);
create or replace view aggView5046187495522889753 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin2341428209202718904 as select v31 from aggJoin6950749849759908560 join aggView5046187495522889753 using(v1);
select MIN(v31) as v31 from aggJoin2341428209202718904;
