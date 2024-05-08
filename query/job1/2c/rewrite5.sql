create or replace view aggView4165788394976191583 as select id as v12, title as v31 from title as t;
create or replace view aggJoin2972218172278015489 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView4165788394976191583 where mk.movie_id=aggView4165788394976191583.v12;
create or replace view aggView4089662393345065025 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin223205556794376236 as select movie_id as v12 from movie_companies as mc, aggView4089662393345065025 where mc.company_id=aggView4089662393345065025.v1;
create or replace view aggView2819758907320195816 as select v12 from aggJoin223205556794376236 group by v12;
create or replace view aggJoin6090725805930992195 as select v18, v31 as v31 from aggJoin2972218172278015489 join aggView2819758907320195816 using(v12);
create or replace view aggView6309975151986741820 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin4560343342566241182 as select v31 from aggJoin6090725805930992195 join aggView6309975151986741820 using(v18);
select MIN(v31) as v31 from aggJoin4560343342566241182;
